class Whistle < Formula
  desc "HTTP, HTTP2, HTTPS, Websocket debugging proxy"
  homepage "https://github.com/avwo/whistle"
  url "https://registry.npmjs.org/whistle/-/whistle-2.9.81.tgz"
  sha256 "7cb420cd820104160e0e9e11c5752c6b68835317edfe0bbc18de1420c7a08d54"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "561d199f44ff5ce970c471f456c8f5399ba7e0f170fc7cd06e16b75649af15d0"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "561d199f44ff5ce970c471f456c8f5399ba7e0f170fc7cd06e16b75649af15d0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "561d199f44ff5ce970c471f456c8f5399ba7e0f170fc7cd06e16b75649af15d0"
    sha256 cellar: :any_skip_relocation, sonoma:         "8166a316153d7d41369705986d8deed80cc7c8f9578d9c5c3564532fce2604d8"
    sha256 cellar: :any_skip_relocation, ventura:        "8166a316153d7d41369705986d8deed80cc7c8f9578d9c5c3564532fce2604d8"
    sha256 cellar: :any_skip_relocation, monterey:       "561d199f44ff5ce970c471f456c8f5399ba7e0f170fc7cd06e16b75649af15d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f5570f48796765e48e714f789c9e04783794a237e96b7c43aa181e15b07b1001"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"package.json").write('{"name": "test"}')
    system bin/"whistle", "start"
    system bin/"whistle", "stop"
  end
end
