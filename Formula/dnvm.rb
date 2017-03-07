class Dnvm < Formula
  desc ".NET Core Version Manager"
  homepage "https://github.com/natemcmaster/dnvm"
  url "https://dnvmtools.blob.core.windows.net/cli/0.1.1/dnvm.osx-64.tar.gz"
  version "0.1.1"
  sha256 "7a9ab1e6b127086d20095272c5eb1878c903baaabf02bda6750c39161487dd11"

  depends_on "openssl"
  depends_on "libyaml"

  option "without-dotnet", "Install DNVM without install the 'dotnet' executable"
  option "without-sdk", "Install DNVM without installing the latest .NET Core SDK"

  def install
    cp_r ".", prefix

    bin.install bin/"dotnet" if build.with?("dotnet")
    bin.install bin/"dnvm"
    bin.install bin/"dnvm-prompt"

    libexec.install_symlink "#{HOMEBREW_PREFIX}/opt/openssl/lib/libcrypto.1.0.0.dylib"
    libexec.install_symlink "#{HOMEBREW_PREFIX}/opt/openssl/lib/libssl.1.0.0.dylib"

    if build.with?("sdk") 
      ohai 'Installing the latest .NET Core. This may take a few minutes...' 
      system bin/"dnvm", "--verbose", "install", "sdk", "stable"
    end
  end

  test do
    assert shell_output("#{bin}/dnvm install sdk stable", result=0)
  end
end
