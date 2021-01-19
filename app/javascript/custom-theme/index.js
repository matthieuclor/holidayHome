const components = require.context('./components/', true, /\.js$/);
components.keys().forEach(components);
