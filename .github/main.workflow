action "Docker build" {
  uses = "actions/docker/cli@86ff551d26008267bb89ac11198ba7f1d807b699"
  args = "build -t jvl ."
  secrets = ["org", "token"]
}
workflow "Build" {
  on = "push"
  resolves = ["Docker build"]
}
