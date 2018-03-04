#include "X11/Xlib.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    const int SCREEN_WIDTH = 2560;
    Display *display = NULL;
    Window defaultRootWindow, rootWindow, childWindow;
    unsigned int mask;
    int rootx = -1, rooty, winx, winy;
    int result = 0;

    display = XOpenDisplay(NULL);
    if (display == NULL) {
        result = -1;
        goto cleanup;
    }

    defaultRootWindow = XDefaultRootWindow(display);

    if (!XQueryPointer(display, defaultRootWindow, &rootWindow, &childWindow, &rootx, &rooty, &winx, &winy, &mask)) {
        result = -1;
        goto cleanup;
    }

    if (rootx < 0 || rootx > 2 * SCREEN_WIDTH) {
        result = -1;
        goto cleanup;
    }

    rootx = (rootx + SCREEN_WIDTH) % (2 * SCREEN_WIDTH);

    if (!XWarpPointer(display, 0, defaultRootWindow, 0, 0, 0, 0, rootx, rooty)) {
        result = -1;
        goto cleanup;
    }

cleanup:
    if (display != NULL) {
        XCloseDisplay(display);
    }

    return result;
}
