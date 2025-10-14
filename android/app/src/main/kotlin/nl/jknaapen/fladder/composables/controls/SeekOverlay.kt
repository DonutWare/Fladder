package nl.jknaapen.fladder.composables.controls

import androidx.compose.animation.core.FastOutLinearInEasing
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.draw.scale
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import io.github.rabehx.iconsax.Iconsax
import io.github.rabehx.iconsax.outline.Refresh
import nl.jknaapen.fladder.utility.visible
import kotlin.math.absoluteValue
import kotlin.time.DurationUnit
import kotlin.time.toDuration

@Composable
internal fun BoxScope.SeekOverlay(
    modifier: Modifier = Modifier,
    value: Long = 0L,
) {

    val infiniteTransition = rememberInfiniteTransition()

    val rotation by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = 360f,
        animationSpec = infiniteRepeatable(
            animation = tween(
                durationMillis = 6000,
                easing = FastOutLinearInEasing,
            ),
        )
    )

    Box(
        modifier = modifier
            .align(Alignment.Center)
            .visible(value != 0L)
            .wrapContentSize()
            .background(
                color = Color.Black.copy(alpha = 0.85f),
                shape = CircleShape
            )
            .padding(12.dp),
        contentAlignment = Alignment.Center,
    ) {
        Icon(
            Iconsax.Outline.Refresh,
            modifier = Modifier
                .size(65.dp)
                .scale(scaleX = if (value < 0) 1f else -1f, scaleY = 1f)
                .rotate(-rotation),
            contentDescription = "SkipLogoRotating",
            tint = Color.White,

            )
        Text(
            value.absoluteValue.toDuration(DurationUnit.MILLISECONDS).inWholeSeconds.toString(),
            modifier = Modifier
                .align(alignment = Alignment.Center),
            color = Color.White
        )
    }
}