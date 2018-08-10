class Kubesec < Formula
  desc "Secure Secret management for Kubernetes (with gpg, Google Cloud KMS and AWS KMS backends)"
  homepage "https://github.com/shyiko/kubesec"
  url "https://github.com/shyiko/kubesec/archive/0.9.2.tar.gz"
  sha256 "49c9a69fc7f4c3d9efba0cbc9110a76f8d3390c4333a97c26e8f868ed84b4078"
  head "https://github.com/shyiko/kubesec.git"
  version "0.9.2"
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
