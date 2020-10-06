/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#000000",   /* after initialization */
	[INPUT] =  "#282a36",   /* during input */
	[FAILED] = "#ff5555",   /* wrong password */
	[CAPS] = "red",         /* CapsLock on */
};

/* opacity*/
static const float alpha = 0.5;
/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "You have a grand gift for silence, Watson. It makes you quite invaluable as a companion";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "6x10";