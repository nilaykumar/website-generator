const metalsmith = require('metalsmith');
const assets = require('metalsmith-static');
const layouts = require('metalsmith-layouts');
const collections = require('metalsmith-collections');
const dateFilter = require('nunjucks-date-filter');

metalsmith(__dirname)
    .source('./src')
    .destination('./nilaykumar.github.io') // the static site is built here
    .use(assets({ // assets are read from and stored here
        src: 'static',
        dest: 'static'
    }))
    .use(collections({ // the blog posts are stored here
        posts: 'posts/*.html'
    }))
    .use(layouts({ // templating
        directory: './src/layouts/', // the layouts are stored here
        default: 'base.njk', // the default layout includes a header/footer
        pattern: '**/*.html',
        engineOptions: {
            filters: {
                date: dateFilter // nunjucks-date-filter is used to make dates readable
            }
        }
    }))
    .build(err => {
        if (err) throw err;
    });
