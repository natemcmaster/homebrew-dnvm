class Dnvm < Formula
  desc ".NET Core Environment Manager"
  homepage "https://github.com/natemcmaster/dnvm"
  devel do
    url "https://dl.dropboxusercontent.com/u/72771334/dnvm.osx-x64.0.1.0-alpha.tar.gz"
    version "0.1.0-alpha"
    sha256 "fa3e46e19a325e82b187f33d374fcc71ee2b797ea680d774917a3c362eeb6b1c"
  end

  depends_on "openssl"

  def install
    system "cp", "-R", ".", prefix
    bin.install bin/"dotnet"
    bin.install bin/"dnvm"
  end

  test do
    assert shell_output("dnvm --version", result=2).include?("0.1.0-alpha"), "dnvm --version didn't include expected version'"
  end
end
