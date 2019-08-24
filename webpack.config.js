var webpack = require('webpack');
var path = require('path');

module.exports = {
  entry: './source/assets/javascripts/index.js',

  resolve: {
    root: path.join(__dirname, 'source/assets/javascripts'),
    modulesDirectories: [
      path.join(__dirname, 'node_modules'),
      path.join(__dirname, 'source/assets/stylesheets')
    ],
    extensions: ['', '.js', '.scss'],
    alias: {
      bootstrap: 'bootstrap-sass/assets/javascripts/bootstrap.min.js'
    }
  },

  output: {
    path: path.join(__dirname, '.tmp/dist'),
    filename: 'assets/javascripts/[name].js'
  },

  module: {
    loaders: [
      {
        test: /\.woff2?$|\.ttf$|\.eot$|\.svg$/,
        loader: 'file'
      },
      {
        test: /\.scss$/,
        loaders: ['style', 'css', 'sass']
      },
      {
        test: /\.(jpg|png)$/,
        loaders: 'file-loader?name=[name].[ext]'
      },
    ]
  },

  sassLoader: {
    includePaths: [path.join(__dirname, 'node_modules')]
  }
};
