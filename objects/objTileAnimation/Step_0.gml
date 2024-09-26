// Update the position manually
x += 2

// Shift the tail positions
for (var i = tailLength - 1; i > 0; i--) {
    tail[i] = tail[i - 1];  // Move each position to the next spot in the array
}

// Store the current position at the start of the array (head of the tail)
tail[0] = [x, y];  // Update tail with the current position