class NeonReleasePr < Formula
  include Language::Python::Virtualenv

  desc "CLI tool for creating and managing release PRs for Neon components"
  homepage "https://github.com/neondatabase/dev-actions/tree/main/release-pr"
  url "https://github.com/neondatabase/dev-actions/archive/31e0e1025b40de54151f442d1f67f17236bd22d6.tar.gz"
  version "0.2.1"
  sha256 "508d3c380e8c4e991a68b32f95140920743d635c9c6f289927e34a354ee3cefd"
  license "Apache-2.0"
  head "https://github.com/neondatabase/dev-actions.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/neondatabase-labs/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1f51aca72e0707f9bbacb3a4c38ad74fbb17eaf9e8b0ab418a1f268bb06dd947"
    sha256 cellar: :any_skip_relocation, ventura:       "168d410c46da4925ed2baefc6c6325d4c14d79e92a4c7ab3a3b2a8aac1ad4cac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7ab6881b9f0c2f94436e5934d64a7f7629dd9e302a0c87569ddbcac08b0267b8"
  end

  depends_on "rust" => :build
  depends_on "gh"
  depends_on "python@3.13"

  resource "click" do
    url "https://files.pythonhosted.org/packages/60/6c/8ca2efa64cf75a977a0d7fac081354553ebe483345c734fb6b6515d96bbc/click-8.2.1.tar.gz"
    sha256 "27c491cc05d968d271d5a1db13e3b5a184636d9d930f148c50b038f0d0646202"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/38/71/3b932df36c1a044d397a1f92d1cf91ee0a503d91e470cbd670aa66b07ed0/markdown-it-py-3.0.0.tar.gz"
    sha256 "e3f60a94fa066dc52ec76661e37c851cb232d92f9886b15cb560aaada2df8feb"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/fe/75/af448d8e52bf1d8fa6a9d089ca6c07ff4453d86c65c145d0a300bb073b9b/rich-14.1.0.tar.gz"
    sha256 "e497a48b844b0320d45007cdebfeaeed8db2a4f4bcf49f15e455cfc4af11eaa8"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/c5/8c/7d682431efca5fd290017663ea4588bf6f2c6aad085c7f108c5dbc316e70/typer-0.16.0.tar.gz"
    sha256 "af377ffaee1dbe37ae9440cb4e8f11686ea5ce4e9bae01b84ae7c63b87f1dd3b"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/98/5a/da40306b885cc8c09109dc2e1abd358d5684b1425678151cdaed4731c822/typing_extensions-4.14.1.tar.gz"
    sha256 "38b39f4aeeab64884ce9f74c94263ef78f3c22467c8724005483154c26648d36"
  end

  def install
    venv = virtualenv_create(libexec, "python3.13")
    venv.pip_install resources
    venv.pip_install_and_link buildpath/"release-pr"
  end

  test do
    system bin/"neon-release-pr", "--help"
  end
end
