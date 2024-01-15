const data = require("./utils/data")
const git = require("git-rev-sync")
const glob = require("glob")
const sass = require("sass")
const hash = git.short()

const sassOptions = {
  indentedSyntax: true,
  logger: sass.Logger.silent,
}

const isDev = process.env.NODE_ENV === "development"

if (isDev) {
  sassOptions.outputStyle = "expanded"
  glob("app/static/**/*.pug", function (err, list) {
    return console.log(
      list
        .filter(function (e) {
          return /features\/[^\/]+\/index/.test(e)
        })
        .map(function (e) {
          return e
            .replace("app/static/", "http://localhost:4000/")
            .replace("index.pug", "")
            .replace(".pug", ".html")
        })
        .join("\n")
    )
  })
}

const marked = function (data = "") {
  return require("marked")
    .marked(data, {
      smartypants: true,
      headerIds: false,
    })
    .replace(
      /(<a href="https?:\/\/\w+\.(?!lowyinstitute\.org)[^>]+)>/g,
      '$1 target="_blank" rel="noreferrer">'
    )
}

module.exports = {
  paths: {
    public: "build",
  },
  server: {
    hostname: "0.0.0.0",
  },
  conventions: {
    assets: /app\/(assets|static)\//,
    ignored: [
      /[\\\/]_/,
      "node_modules",
      isDev ? /\/(partials)\// : /\/(partials|test)\//,
      /^app\/static(\/|\\)(.+)\.(psd|coffee|sass|md|yaml)$/,
      /\.(tmp\$\$)$/,
    ],
  },
  plugins: {
    autoprefixer: {
      browsers: ["> 1%"],
    },
    pug: {
      staticBasedir: "app/static/",
      locals: {
        _: require("lodash"),
        moment: require("moment"),
        typogr: require("typogr"),
        written: require("written"),
        package: require("./package.json"),
        marked: marked,
        data: data,
        version: hash,
        r: function () {
          delete require.cache[require.resolve(arguments[0])]
          return require(arguments[0])
        },
      },
      filters: {
        sass: function (data) {
          return require("sass")
            .renderSync(
              Object.assign(sassOptions, {
                data: '@import "app/sass/core/vars.sass"\n' + data,
              })
            )
            .css.toString()
        },
        coffee: function (data) {
          return require("coffeescript").compile(data)
        },
        marked: marked,
      },
    },
    sass: {
      mode: "native",
    },
    coffeelint: {
      pattern: /^app\/.*\.coffee$/,
      options: {
        no_empty_param_list: {
          level: "error",
        },
        prefer_english_operator: {
          value: true,
          level: "warn",
        },
        indentation: {
          value: 2,
          level: "warn",
        },
        max_line_length: {
          level: "warn",
        },
      },
    },
    postcss: {
      processors: [
        require("autoprefixer")(["> 1%"]),
        require("csswring")({
          preserveHacks: true,
        }),
      ],
    },
  },
  files: {
    javascripts: {
      joinTo: {
        ["js/app." + hash + ".js"]: /^app\//,
        ["js/vendor." + hash + ".js"]: /^(vendor)/,
      },
      order: {
        before: ["vendor/js/vendor.js"],
      },
    },
    stylesheets: {
      joinTo: {
        ["css/app." + hash + ".css"]: "app/sass/app.sass",
      },
    },
    templates: {
      joinTo: {
        ["js/app." + hash + ".js"]: /^app\/templates(\/|\\)(.+)\.pug$/,
      },
    },
  },
  framework: "backbone",
}
