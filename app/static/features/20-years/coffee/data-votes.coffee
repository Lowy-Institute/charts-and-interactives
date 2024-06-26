require.register "data/votes", (exports, require, module) ->
  module.exports = [
    {ring: 0, cx:  0, cy:  0},
    {ring: 1, cx:  0, cy:  7.5},
    {ring: 1, cx: -7.13292, cy:  2.31762},
    {ring: 1, cx: -4.40838, cy: -6.06762},
    {ring: 1, cx:  4.40838, cy: -6.06762},
    {ring: 1, cx:  7.13292, cy:  2.31762},
    {ring: 2, cx:  0, cy: -15},
    {ring: 2, cx:  8.10961, cy: -12.61880},
    {ring: 2, cx:  13.64447, cy: -6.23122},
    {ring: 2, cx:  14.84732, cy:  2.13472},
    {ring: 2, cx:  11.33624, cy:  9.82291},
    {ring: 2, cx:  4.22598, cy:  14.39239},
    {ring: 2, cx: -4.22598, cy:  14.39239},
    {ring: 2, cx: -11.33624, cy:  9.82291},
    {ring: 2, cx: -14.84732, cy:  2.13472},
    {ring: 2, cx: -13.64447, cy: -6.23122},
    {ring: 2, cx: -8.10961, cy: -12.61880},
    {ring: 3, cx:  0, cy:  22.5},
    {ring: 3, cx: -8.12793, cy:  20.98062},
    {ring: 3, cx: -15.15815, cy:  16.62770},
    {ring: 3, cx: -20.14117, cy:  10.02911},
    {ring: 3, cx: -22.40401, cy:  2.07603},
    {ring: 3, cx: -21.64107, cy: -6.15741},
    {ring: 3, cx: -17.95538, cy: -13.55927},
    {ring: 3, cx: -11.84472, cy: -19.12988},
    {ring: 3, cx: -4.13436, cy: -22.11689},
    {ring: 3, cx:  4.13436, cy: -22.11689},
    {ring: 3, cx:  11.84472, cy: -19.12988},
    {ring: 3, cx:  17.95538, cy: -13.55927},
    {ring: 3, cx:  21.64107, cy: -6.15741},
    {ring: 3, cx:  22.40401, cy:  2.07603},
    {ring: 3, cx:  20.14117, cy:  10.02911},
    {ring: 3, cx:  15.15815, cy:  16.62770},
    {ring: 3, cx:  8.12793, cy:  20.98062},
    {ring: 4, cx:  0, cy: -30},
    {ring: 4, cx:  8.45197, cy: -28.78478},
    {ring: 4, cx:  16.21922, cy: -25.23760},
    {ring: 4, cx:  22.67248, cy: -19.64582},
    {ring: 4, cx:  27.28895, cy: -12.46245},
    {ring: 4, cx:  29.69464, cy: -4.26944},
    {ring: 4, cx:  29.69464, cy:  4.26944},
    {ring: 4, cx:  27.28895, cy:  12.46245},
    {ring: 4, cx:  22.67248, cy:  19.64582},
    {ring: 4, cx:  16.21922, cy:  25.23760},
    {ring: 4, cx:  8.45197, cy:  28.78478},
    {ring: 4, cx:  0, cy:  30},
    {ring: 4, cx: -8.45197, cy:  28.78478},
    {ring: 4, cx: -16.21922, cy:  25.23760},
    {ring: 4, cx: -22.67248, cy:  19.64582},
    {ring: 4, cx: -27.28895, cy:  12.46245},
    {ring: 4, cx: -29.69464, cy:  4.26944},
    {ring: 4, cx: -29.69464, cy: -4.26944},
    {ring: 4, cx: -27.28895, cy: -12.46245},
    {ring: 4, cx: -22.67248, cy: -19.64582},
    {ring: 4, cx: -16.21922, cy: -25.23760},
    {ring: 4, cx: -8.45197, cy: -28.78478},
    {ring: 5, cx:  0, cy:  37.5},
    {ring: 5, cx: -8.34453, cy:  36.55979},
    {ring: 5, cx: -16.27064, cy:  33.78633},
    {ring: 5, cx: -23.38086, cy:  29.31868},
    {ring: 5, cx: -29.31868, cy:  23.38086},
    {ring: 5, cx: -33.78633, cy:  16.27064},
    {ring: 5, cx: -36.55979, cy:  8.34453},
    {ring: 5, cx: -37.5, cy:  0},
    {ring: 5, cx: -36.55979, cy: -8.34453},
    {ring: 5, cx: -33.78633, cy: -16.27064},
    {ring: 5, cx: -29.31868, cy: -23.38086},
    {ring: 5, cx: -23.38086, cy: -29.31868},
    {ring: 5, cx: -16.27064, cy: -33.78633},
    {ring: 5, cx: -8.34453, cy: -36.55979},
    {ring: 5, cx:  0, cy: -37.5},
    {ring: 5, cx:  8.34453, cy: -36.55979},
    {ring: 5, cx:  16.27064, cy: -33.78633},
    {ring: 5, cx:  23.38086, cy: -29.31868},
    {ring: 5, cx:  29.31868, cy: -23.38086},
    {ring: 5, cx:  33.78633, cy: -16.27064},
    {ring: 5, cx:  36.55979, cy: -8.34453},
    {ring: 5, cx:  37.5, cy:  0},
    {ring: 5, cx:  36.55979, cy:  8.34453},
    {ring: 5, cx:  33.78633, cy:  16.27064},
    {ring: 5, cx:  29.31868, cy:  23.38086},
    {ring: 5, cx:  23.38086, cy:  29.31868},
    {ring: 5, cx:  16.27064, cy:  33.78633},
    {ring: 5, cx:  8.34453, cy:  36.55979},
    {ring: 6, cx:  0, cy: -45},
    {ring: 6, cx:  8.26872, cy: -44.23378},
    {ring: 6, cx:  16.25587, cy: -41.96125},
    {ring: 6, cx:  23.68944, cy: -38.25977},
    {ring: 6, cx:  30.31630, cy: -33.25540},
    {ring: 6, cx:  35.91077, cy: -27.11855},
    {ring: 6, cx:  40.28234, cy: -20.05822},
    {ring: 6, cx:  43.28215, cy: -12.31483},
    {ring: 6, cx:  44.80803, cy: -4.15207},
    {ring: 6, cx:  44.80803, cy:  4.15207},
    {ring: 6, cx:  43.28215, cy:  12.31483},
    {ring: 6, cx:  40.28234, cy:  20.05822},
    {ring: 6, cx:  35.91077, cy:  27.11855},
    {ring: 6, cx:  30.31630, cy:  33.25540},
    {ring: 6, cx:  23.68944, cy:  38.25977},
    {ring: 6, cx:  16.25587, cy:  41.96125},
    {ring: 6, cx:  8.26872, cy:  44.23378},
    {ring: 6, cx:  0, cy:  45},
    {ring: 6, cx: -8.26872, cy:  44.23378},
    {ring: 6, cx: -16.25587, cy:  41.96125},
    {ring: 6, cx: -23.68944, cy:  38.25977},
    {ring: 6, cx: -30.31630, cy:  33.25540},
    {ring: 6, cx: -35.91077, cy:  27.11855},
    {ring: 6, cx: -40.28234, cy:  20.05822},
    {ring: 6, cx: -43.28215, cy:  12.31483},
    {ring: 6, cx: -44.80803, cy:  4.15207},
    {ring: 6, cx: -44.80803, cy: -4.15207},
    {ring: 6, cx: -43.28215, cy: -12.31483},
    {ring: 6, cx: -40.28234, cy: -20.05822},
    {ring: 6, cx: -35.91077, cy: -27.11855},
    {ring: 6, cx: -30.31630, cy: -33.25540},
    {ring: 6, cx: -23.68944, cy: -38.25977},
    {ring: 6, cx: -16.25587, cy: -41.96125},
    {ring: 6, cx: -8.26872, cy: -44.23378},
    {ring: 7, cx:  0, cy:  52.5},
    {ring: 7, cx: -8.42159, cy:  51.82013},
    {ring: 7, cx: -16.62506, cy:  49.79816},
    {ring: 7, cx: -24.39796, cy:  46.48644},
    {ring: 7, cx: -31.53896, cy:  41.97074},
    {ring: 7, cx: -37.86312, cy:  36.36802},
    {ring: 7, cx: -43.20665, cy:  29.82339},
    {ring: 7, cx: -47.43114, cy:  22.50635},
    {ring: 7, cx: -50.42720, cy:  14.60641},
    {ring: 7, cx: -52.11721, cy:  6.32817},
    {ring: 7, cx: -52.45742, cy: -2.11396},
    {ring: 7, cx: -51.43900, cy: -10.50134},
    {ring: 7, cx: -49.08835, cy: -18.61675},
    {ring: 7, cx: -45.46633, cy: -26.24999},
    {ring: 7, cx: -40.66676, cy: -33.20338},
    {ring: 7, cx: -34.81393, cy: -39.29681},
    {ring: 7, cx: -28.05945, cy: -44.37247},
    {ring: 7, cx: -20.57824, cy: -48.29892},
    {ring: 7, cx: -12.56407, cy: -50.97444},
    {ring: 7, cx: -4.22449, cy: -52.32975},
    {ring: 7, cx:  4.22449, cy: -52.32975},
    {ring: 7, cx:  12.56407, cy: -50.97444},
    {ring: 7, cx:  20.57824, cy: -48.29892},
    {ring: 7, cx:  28.05945, cy: -44.37247},
    {ring: 7, cx:  34.81393, cy: -39.29681},
    {ring: 7, cx:  40.66676, cy: -33.20338},
    {ring: 7, cx:  45.46633, cy: -26.25000},
    {ring: 7, cx:  49.08835, cy: -18.61675},
    {ring: 7, cx:  51.43900, cy: -10.50134},
    {ring: 7, cx:  52.45742, cy: -2.11396},
    {ring: 7, cx:  52.11721, cy:  6.32817},
    {ring: 7, cx:  50.42720, cy:  14.60641},
    {ring: 7, cx:  47.43114, cy:  22.50635},
    {ring: 7, cx:  43.20665, cy:  29.82339},
    {ring: 7, cx:  37.86312, cy:  36.36802},
    {ring: 7, cx:  31.53896, cy:  41.97074},
    {ring: 7, cx:  24.39796, cy:  46.48644},
    {ring: 7, cx:  16.62506, cy:  49.79816},
    {ring: 7, cx:  8.42159, cy:  51.82013},
    {ring: 8, cx:  0, cy: -60},
    {ring: 8, cx:  10.71341, cy: -59.03577},
    {ring: 8, cx:  21.08248, cy: -56.17409},
    {ring: 8, cx:  30.77395, cy: -51.50692},
    {ring: 8, cx:  39.47632, cy: -45.18428},
    {ring: 8, cx:  46.90988, cy: -37.40938},
    {ring: 8, cx:  52.83573, cy: -28.43211},
    {ring: 8, cx:  57.06339, cy: -18.54101},
    {ring: 8, cx:  59.45698, cy: -8.05399},
    {ring: 8, cx:  59.93958, cy:  2.69188},
    {ring: 8, cx:  58.49567, cy:  13.35125},
    {ring: 8, cx:  55.17166, cy:  23.58150},
    {ring: 8, cx:  50.07439, cy:  33.05381},
    {ring: 8, cx:  43.36769, cy:  41.46375},
    {ring: 8, cx:  35.26711, cy:  48.54101},
    {ring: 8, cx:  26.03302, cy:  54.05813},
    {ring: 8, cx:  15.96221, cy:  57.83777},
    {ring: 8, cx:  5.37835, cy:  59.75845},
    {ring: 8, cx: -5.37835, cy:  59.75845},
    {ring: 8, cx: -15.96221, cy:  57.83777},
    {ring: 8, cx: -26.03302, cy:  54.05813},
    {ring: 8, cx: -35.26711, cy:  48.54101},
    {ring: 8, cx: -43.36769, cy:  41.46375},
    {ring: 8, cx: -50.07439, cy:  33.05381},
    {ring: 8, cx: -55.17166, cy:  23.58150},
    {ring: 8, cx: -58.49567, cy:  13.35125},
    {ring: 8, cx: -59.93958, cy:  2.69188},
    {ring: 8, cx: -59.45698, cy: -8.05399},
    {ring: 8, cx: -57.06339, cy: -18.54101},
    {ring: 8, cx: -52.83573, cy: -28.43211},
    {ring: 8, cx: -46.90988, cy: -37.40938},
    {ring: 8, cx: -39.47632, cy: -45.18428},
    {ring: 8, cx: -30.77395, cy: -51.50692},
    {ring: 8, cx: -21.08248, cy: -56.17409},
    {ring: 8, cx: -10.71341, cy: -59.03577}
  ]
