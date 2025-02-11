class Liquibase < Formula
  desc "Library for database change tracking"
  homepage "https://www.liquibase.org/"
  url "https://github.com/liquibase/liquibase/releases/download/v4.16.0/liquibase-4.16.0.tar.gz"
  sha256 "2da4884b8f175431b638bb99fdc4f0402ae5fd3f1d6ad9a6f50b5b13752ab73a"
  license "Apache-2.0"

  livecheck do
    url "https://www.liquibase.org/download"
    regex(/href=.*?liquibase[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dcb4c92a72d97f0d25ecd321cfaf0720257f7296dd69403491be3ec0ee7bada6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dcb4c92a72d97f0d25ecd321cfaf0720257f7296dd69403491be3ec0ee7bada6"
    sha256 cellar: :any_skip_relocation, monterey:       "e43d07ee805939c68b0422340b058ee4e254bc9d5e49e54a65e8c67f70dca517"
    sha256 cellar: :any_skip_relocation, big_sur:        "e43d07ee805939c68b0422340b058ee4e254bc9d5e49e54a65e8c67f70dca517"
    sha256 cellar: :any_skip_relocation, catalina:       "e43d07ee805939c68b0422340b058ee4e254bc9d5e49e54a65e8c67f70dca517"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dcb4c92a72d97f0d25ecd321cfaf0720257f7296dd69403491be3ec0ee7bada6"
  end

  depends_on "openjdk"

  def install
    rm_f Dir["*.bat"]
    chmod 0755, "liquibase"
    prefix.install_metafiles
    libexec.install Dir["*"]
    (bin/"liquibase").write_env_script libexec/"liquibase", Language::Java.overridable_java_home_env
    (libexec/"lib").install_symlink Dir["#{libexec}/sdk/lib-sdk/slf4j*"]
  end

  def caveats
    <<~EOS
      You should set the environment variable LIQUIBASE_HOME to
        #{opt_libexec}
    EOS
  end

  test do
    system "#{bin}/liquibase", "--version"
  end
end
