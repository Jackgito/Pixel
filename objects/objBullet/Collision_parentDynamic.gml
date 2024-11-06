var screenShake = false;
if (other == objPlayer) screenShake = true;
with (objPlayer) takeDamage(1, screenShake);
explosionHit();