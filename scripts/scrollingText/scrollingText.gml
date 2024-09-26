function scrollingText(text, scrollSpeed, gap, textY) {
	var textX = display_get_gui_width() / 2;
	textY -= scrollSpeed;
	draw_text_ext(textX, textY, text, gap, -1);
	return textY;
}