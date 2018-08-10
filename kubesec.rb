class Kubesec < Formula
  desc "Secure Secret management for Kubernetes (with gpg, Google Cloud KMS and AWS KMS backends)"
  homepage "https://github.com/shyiko/kubesec"
  url "https://github.com/shyiko/kubesec/archive/0.9.1.tar.gz"
  sha256 "2e00e8b08e5b6b61c400d0b97b5c0ef3b5945adb31a8d4df6ec8f5c5091d7f5a"
  head "https://github.com/shyiko/kubesec.git"
  version "0.9.1"
  depends_on "go" => :build

  option "with-short-name", "link as ksec instead"

  def install
    ENV["GOPATH"] = buildpath
    ENV["PATH"]  = "#{ENV["PATH"]}:#{ENV["GOPATH"]}/bin"
    (buildpath/"src/github.com/shyiko/kubesec").install buildpath.children
    cd "src/github.com/shyiko/kubesec" do
      system "make", "fetch"
      system "make", "build"
      bin.install "kubesec" => build.with?("short-name") ? "ksec" : "kubesec"
    end
  end

  test do
    system bin/"kubesec", "--version"
  end
end
