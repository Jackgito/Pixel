// Movement speed of the line
speedX = irandom_range(-2, 2)


// Initial position of the line



// Tail length and setup
tailLength = 30;  // Number of points in the tail
tail = array_create(tailLength);  // Create array to store positions

// Initialize the tail with the current position
for (var i = 0; i < tailLength; i++) {
    tail[i] = [x, y];  // Store the same position initially
}