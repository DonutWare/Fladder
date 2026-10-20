#include "my_application.h"

#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#endif

#include "flutter/generated_plugin_registrant.h"

struct _MyApplication
{
	GtkApplication parent_instance;
	char **dart_entrypoint_arguments;
};

G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)

// Implements GApplication::activate.
static void my_application_activate(GApplication *application)
{
	MyApplication *self = MY_APPLICATION(application);

	GtkWindow *existing_window = gtk_application_get_active_window(GTK_APPLICATION(application));
	if (existing_window != nullptr)
	{
		gtk_window_present(existing_window);
		return;
	}

	GtkWindow *window =
		GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

	// Use a header bar when running in GNOME as this is the common style used
	// by applications and is the setup most users will be using (e.g. Ubuntu
	// desktop).
	// If running on X and not using GNOME then just use a traditional title bar
	// in case the window manager does more exotic layout, e.g. tiling.
	// If running on Wayland assume the header bar will work (may need changing
	// if future cases occur).
	gboolean use_header_bar = TRUE;
#ifdef GDK_WINDOWING_X11
	GdkScreen *screen = gtk_window_get_screen(window);
	if (GDK_IS_X11_SCREEN(screen))
	{
		const gchar *wm_name = gdk_x11_screen_get_window_manager_name(screen);
		if (g_strcmp0(wm_name, "GNOME Shell") != 0)
		{
			use_header_bar = FALSE;
		}
	}
#endif
	if (use_header_bar)
	{
		GtkHeaderBar *header_bar = GTK_HEADER_BAR(gtk_header_bar_new());
		gtk_widget_show(GTK_WIDGET(header_bar));
		gtk_header_bar_set_title(header_bar, "Fladder");
		gtk_header_bar_set_show_close_button(header_bar, TRUE);
		gtk_window_set_titlebar(window, GTK_WIDGET(header_bar));
	}
	else
	{
		gtk_window_set_title(window, "Fladder");
	}

	gtk_window_set_default_size(window, 1280, 720);
	gtk_widget_show(GTK_WIDGET(window));

	g_autoptr(FlDartProject) project = fl_dart_project_new();
	fl_dart_project_set_dart_entrypoint_arguments(project, self->dart_entrypoint_arguments);

	FlView *view = fl_view_new(project);
	gtk_widget_show(GTK_WIDGET(view));
	gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));

	fl_register_plugins(FL_PLUGIN_REGISTRY(view));

	gtk_widget_grab_focus(GTK_WIDGET(view));
}

// Implements GApplication::local_command_line.
static gboolean my_application_local_command_line(GApplication *application, gchar ***arguments, int *exit_status)
{
	g_autoptr(GError) error = nullptr;
	if (!g_application_register(application, nullptr, &error))
	{
		g_warning("Failed to register: %s", error->message);
		g_application_set_flags(application, static_cast<GApplicationFlags>(g_application_get_flags(application) | G_APPLICATION_NON_UNIQUE));
	}

	return G_APPLICATION_CLASS(my_application_parent_class)->local_command_line(application, arguments, exit_status);
}

static gint my_application_command_line(GApplication *application, GApplicationCommandLine *command_line)
{
	MyApplication *self = MY_APPLICATION(application);

	if (gtk_application_get_active_window(GTK_APPLICATION(application)) != nullptr)
	{
		g_application_activate(application);
		return 0;
	}

	gint argc = 0;
	g_auto(GStrv) argv = g_application_command_line_get_arguments(command_line, &argc);
	g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
	self->dart_entrypoint_arguments = argc > 0 ? g_strdupv(argv + 1) : nullptr;

	g_application_activate(application);
	return 0;
}

// Implements GObject::dispose.
static void my_application_dispose(GObject *object)
{
	MyApplication *self = MY_APPLICATION(object);
	g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
	G_OBJECT_CLASS(my_application_parent_class)->dispose(object);
}

static void my_application_class_init(MyApplicationClass *klass)
{
	G_APPLICATION_CLASS(klass)->activate = my_application_activate;
	G_APPLICATION_CLASS(klass)->local_command_line = my_application_local_command_line;
	G_APPLICATION_CLASS(klass)->command_line = my_application_command_line;
	G_OBJECT_CLASS(klass)->dispose = my_application_dispose;
}

static void my_application_init(MyApplication *self) {}

MyApplication *my_application_new(gboolean new_instance)
{
	g_set_prgname("fladder");
	GApplicationFlags flags = G_APPLICATION_HANDLES_COMMAND_LINE;
	if (new_instance)
	{
		flags = static_cast<GApplicationFlags>(flags | G_APPLICATION_NON_UNIQUE);
	}
	return MY_APPLICATION(g_object_new(my_application_get_type(),
									   "application-id", APPLICATION_ID,
									   "flags", flags,
									   nullptr));
}
