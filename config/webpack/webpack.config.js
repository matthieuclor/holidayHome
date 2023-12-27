const { generateWebpackConfig, merge } = require('shakapacker')
const vueConfig = require('./rules/vue')
const webpackConfig = generateWebpackConfig()

module.exports = merge(vueConfig, webpackConfig)