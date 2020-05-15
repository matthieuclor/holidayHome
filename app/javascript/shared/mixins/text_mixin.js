export default {
  methods: {
    pluralize(count, string, suffix = 's') {
      string = count > 1 ? string.split(' ').join(`${suffix} `) + suffix : string
      return `${count} ${string}`
    }
  }
}
