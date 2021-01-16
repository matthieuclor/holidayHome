export default {
  methods: {
    pluralize(count, string, suffix = 's') {
      const word = count > 1 ? string.split(' ').join(`${suffix} `) + suffix : string;
      return `${count} ${word}`;
    },
  },
};
