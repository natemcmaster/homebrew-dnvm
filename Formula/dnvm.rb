class Dnvm < Formula
  desc ".NET Core Version Manager"
  homepage "https://github.com/natemcmaster/dnvm"
  url "https://dnvmtools.blob.core.windows.net/cli/0.2.0/dnvm.osx-x64.0.2.0.tar.gz"
  version "0.2.0"
  sha256 "7cdac8ec2851bf9cf5d9b2432fefdb54b36ca928bbdf4cc4dbf049e331bde113"

  depends_on "openssl"
  depends_on "libyaml"

  option "without-dotnet", "Install DNVM without install the 'dotnet' executable"
  option "with-sdk", "Install DNVM and install the latest .NET Core SDK"

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
