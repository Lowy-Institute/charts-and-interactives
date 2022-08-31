## Structure

```
the-xi-jinping-era/
  - index.pug     # The wrapper template
  - _slides.pug   # Template which includes individual slides
  - _styles.sass  # Sass file imports components
  - data/
    - data.yaml   # Any slide data can be added here
  - slides/       # Folder with slide templates
  - style/        # Folder with sass component files
  - img/          # Folder with presentation images

```

The slides are individual Pug templates, and are included by the `_slides.pug`
template. Some templates create multiple slides.

Data added to the `data.yaml` file is available in the slides in the
`page.data`.

The views which control the presentation are located in the
`chinas-communist-party-under-xi-jinping` presentation. These view components
can be controlled by `data-attributes`, and so they are not duplicated within
this presentation. For example, the typing animation can be controlled using
`data-duration` and `data-delay`. Other animations use the `.fade-in` class
combined with `.delay-x` classes.

On the other hand, the Sass files are duplicated to make it
easy to change the visuals without affecting the older presentation.

## Conversion

Once the slides are ready to present, they need to be converted to videos. This
can be done by screen-recording a single run through of the presentation and
then splitting the recording into individual slides. Then the videos are added
to PowerPoint for Richard to take with him on a USB stick. This process should
only be done once the slides are confirmed to prevent unnecessary work
re-capturing the slides. Richard has a PowerPoint file from the previous
presentation, which can be referenced if needed. PowerPoint is used to allow
Richard to reorder slides on the go.

## Assets

You can find existing Photoshop and Illustrator assets in this
password-protected archive.
https://share.s-ings.com/lowy/the-xi-jinping-era-assets.zip

Username: lowy
Password: 31bligh

Note that the PSD for the first slide doesn't exactily match the image used.
I made edits to make this image better resemble Xi, but those edits were lost.
