const path = require('path');
const webpack = require('webpack');
const htmlplugin = require('html-webpack-plugin');
const extractTextPlugin = require('extract-text-webpack-plugin');
const cleaner = require('clean-webpack-plugin');
// const glob = require('glob');
module.exports = {
  entry: {
    index: './src/js/index.js',
  
  },
  output: {
    path: path.resolve(__dirname, 'dist/'),
    filename: 'js/[name].js',
    publicPath: 'http://localhost:8080/'
  },
  module: {
    rules: [
      {
        test: /\.art$/,
        use: [{
          loader: 'art-template-loader'
        }]
      },
      {
        test: /\.scss$/,
        use: extractTextPlugin.extract({
          use: [{
            loader: "css-loader"
          }, {
            loader: 'postcss-loader'
          }, {
            loader: "sass-loader"
          }],
          // use style-loader in development
          fallback: "style-loader"
        })
      },
      {
        test: /\.(png|jpg|gif)$/,
        use: [{
          loader: 'url-loader',
          options: {
            limit: 500,
            outputPath: 'images/',
          }
        }]
      },
      {
        test: /\.(jsx|js)$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              "es2015", "react"
            ]
          }
        },
        exclude: /node_modules/
      }
    ]
  },
  plugins: [
    new cleaner('dist'),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      'window.jQuery': 'jquery',
      'window.$': 'jquery',
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name:['jquery'],
      filename:'assets/js/[name].js',
      minChunks:2
    }),
    new extractTextPlugin('css/[name].css'),
    new htmlplugin({
      template: './src/index.art'
    }),

  ],
  devServer: {
    contentBase: path.resolve(__dirname, 'dist'),
    host: 'localhost',
    port: 8080, // 默认8080
    compress: true
  }
}