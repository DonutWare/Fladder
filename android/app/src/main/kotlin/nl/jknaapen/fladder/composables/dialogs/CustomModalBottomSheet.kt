package nl.jknaapen.fladder.composables.dialogs

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.displayCutoutPadding
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.SheetValue
import androidx.compose.material3.rememberModalBottomSheetState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
internal fun CustomModalBottomSheet(
    onDismissRequest: () -> Unit,
    maxWidth: Dp = LocalConfiguration.current.screenWidthDp.dp,
    content: @Composable () -> Unit,
) {
    val modalBottomSheetState = rememberModalBottomSheetState(
        skipPartiallyExpanded = true,
        confirmValueChange = { newValue ->
            newValue == SheetValue.Expanded ||
                    newValue == SheetValue.Hidden
        }
    )

    LaunchedEffect(Unit) {
        modalBottomSheetState.expand()
    }

    ModalBottomSheet(
        onDismissRequest,
        dragHandle = null,
        sheetState = modalBottomSheetState,
        contentWindowInsets = { WindowInsets(0, 0, 0, 0) },
        containerColor = Color.Transparent,
        sheetMaxWidth = maxWidth,
    ) {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .displayCutoutPadding()
                .background(
                    shape = RoundedCornerShape(16.dp),
                    brush = Brush.linearGradient(
                        colors = listOf(
                            Color.Black.copy(alpha = 0.65f),
                            Color.Black.copy(alpha = 0.85f),
                        ),
                        start = Offset(0f, 0f),
                        end = Offset(0f, Float.POSITIVE_INFINITY)
                    )
                )
                .navigationBarsPadding()
        ) {
            content()
        }
    }
}