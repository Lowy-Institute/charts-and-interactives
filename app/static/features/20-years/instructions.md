To add the video slide back in:

1. Overwrite the video thumbnail in `./img/youtube-thumbnail.webp`
2. Update the pug file `./partials/slides/13.pug`
3. In `index.pug`, uncomment `+item(13)` and change the 14th slide back to `+item(14,8)`. Also change `#scroller[data-max] to 15`
4. In `./partials/other/background-gallery.pug`, do the same for `+gallery-slider(...)`
5. In `header` and `footer` partials, change the 14s to 15
