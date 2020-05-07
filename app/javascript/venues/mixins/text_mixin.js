export default {
  methods: {
    pluralize(count, string, suffix = 's') {
      return `${count} ${string}${count > 1 ? suffix : ''}`
    }
  }
}
