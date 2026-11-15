#include "my_application.h"

#include <string.h>

int main(int argc, char** argv) {
  gboolean new_instance = FALSE;
  for (int i = 1; i < argc; i++) {
    if (strcmp(argv[i], "--newInstance") == 0) {
      new_instance = TRUE;
    }
  }

  g_autoptr(MyApplication) app = my_application_new(new_instance);
  return g_application_run(G_APPLICATION(app), argc, argv);
}
