const components = require.context('.', true, /_component\.js$/);
components.keys().forEach(components);
