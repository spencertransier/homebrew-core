class Uv < Formula
  desc "Extremely fast Python package installer and resolver, written in Rust"
  homepage "https://github.com/astral-sh/uv"
  url "https://github.com/astral-sh/uv/archive/refs/tags/0.2.37.tar.gz"
  sha256 "158ad67b27c9aca0deac28ded88e9047ff338564f23a104de4dfcef21cd3a074"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/astral-sh/uv.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7ea0ba1243aeafc455ae8d463d12dd24de266ad3ead9d65c2d34cb92fee7c8ce"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "141472e87ae3d39b141fb231cee09a04861b4578373bba60caf52e517284f06a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ccf476c8eb14858178a016fe354b028b2038401a09ea4441fe771f822575ca39"
    sha256 cellar: :any_skip_relocation, sonoma:         "4e64f93eeefee35d64d2ebc9ffb18d02a3a4929d07616786a853978cb1c0b098"
    sha256 cellar: :any_skip_relocation, ventura:        "871b08e5527fef5223cee7bff1c84828a64c79a1f1e6afc3f8530e5d43243f49"
    sha256 cellar: :any_skip_relocation, monterey:       "cbfde09bd49bd0b0df6e28a9ec167e6788d57b2358abb52b65fe26c5f028ab42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2ce05705ed3450cc2035c4ce71ce078240f366a15c506b26499fbd08660106ec"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  uses_from_macos "python" => :test
  uses_from_macos "xz"

  on_linux do
    # On macOS, bzip2-sys will use the bundled lib as it cannot find the system or brew lib.
    # We only ship bzip2.pc on Linux which bzip2-sys needs to find library.
    depends_on "bzip2"
  end

  def install
    ENV["UV_COMMIT_HASH"] = ENV["UV_COMMIT_SHORT_HASH"] = tap.user
    ENV["UV_COMMIT_DATE"] = time.strftime("%F")
    system "cargo", "install", "--no-default-features", *std_cargo_args(path: "crates/uv")
    generate_completions_from_executable(bin/"uv", "generate-shell-completion")
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      requests
    EOS

    compiled = shell_output("#{bin}/uv pip compile -q requirements.in")
    assert_match "This file was autogenerated by uv", compiled
    assert_match "# via requests", compiled

    assert_match "ruff 0.5.1", shell_output("#{bin}/uvx -q ruff@0.5.1 --version")
  end
end
