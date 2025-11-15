package nl.jknaapen.fladder.composables.overlays.screensavers

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.IntSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import nl.jknaapen.fladder.composables.shared.CurrentTime
import kotlin.math.roundToInt
import kotlin.random.Random

@Composable
internal fun ScreensaverDvd(
    modifier: Modifier = Modifier,
    velocityX: Dp = 4.dp,
    velocityY: Dp = 4.dp,
    logo: @Composable (color: Color) -> Unit = { color ->
        Text(
            text = "FLADDER",
            color = color,
            style = MaterialTheme.typography.bodyMedium.copy(
                fontSize = 36.sp,
                fontWeight = FontWeight.Bold,
            ),
        )
    }
) {
    val density = LocalDensity.current

    val velocityPx = remember(velocityX, velocityY, density) {
        with(density) {
            Offset(velocityX.toPx(), velocityY.toPx())
        }
    }

    BoxWithConstraints(
        modifier = modifier
            .fillMaxSize()
            .background(Color.Black)
    ) {
        val containerWidthPx = with(density) { maxWidth.toPx() }
        val containerHeightPx = with(density) { maxHeight.toPx() }

        var position by remember { mutableStateOf(Offset(0f, 0f)) }
        var velocity by remember { mutableStateOf(velocityPx) }
        var color by remember { mutableStateOf(Color.Red) }
        var logoSize by remember { mutableStateOf(IntSize.Zero) }

        LaunchedEffect(containerWidthPx, containerHeightPx, logoSize, velocityPx) {
            if (containerWidthPx == 0f || containerHeightPx == 0f || logoSize == IntSize.Zero) {
                return@LaunchedEffect
            }

            velocity = velocity.takeIf { it.x != 0f && it.y != 0f } ?: velocityPx

            while (isActive) {
                var newX = position.x + velocity.x
                var newY = position.y + velocity.y
                var newVelocity = velocity
                var didBounce = false

                val logoWidthPx = logoSize.width
                val logoHeightPx = logoSize.height

                if (newX <= 0f) {
                    newX = 0f
                    newVelocity = newVelocity.copy(x = -velocity.x)
                    didBounce = true
                } else if (newX + logoWidthPx >= containerWidthPx) {
                    newX = containerWidthPx - logoWidthPx
                    newVelocity = newVelocity.copy(x = -velocity.x)
                    didBounce = true
                }

                if (newY <= 0f) {
                    newY = 0f
                    newVelocity = newVelocity.copy(y = -velocity.y)
                    didBounce = true
                } else if (newY + logoHeightPx >= containerHeightPx) {
                    newY = containerHeightPx - logoHeightPx
                    newVelocity = newVelocity.copy(y = -velocity.y)
                    didBounce = true
                }

                position = Offset(newX, newY)
                velocity = newVelocity
                if (didBounce) {
                    color = randomColor()
                }

                delay(16L)
            }
        }

        Box(
            modifier = Modifier
                .offset { IntOffset(position.x.roundToInt(), position.y.roundToInt()) }
                .onSizeChanged { logoSize = it }
        ) {
            logo(color)
        }

        CurrentTime(
            modifier = Modifier
                .padding(8.dp)
                .align(alignment = Alignment.TopEnd)
        )
    }
}

private fun randomColor(): Color {
    return Color(
        red = Random.nextInt(50, 256),
        green = Random.nextInt(50, 256),
        blue = Random.nextInt(50, 256)
    )
}