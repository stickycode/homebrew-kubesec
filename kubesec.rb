class Kubesec < Formula
  desc "Secure Secret management for Kubernetes (with gpg, Google Cloud KMS and AWS KMS backends)"
  homepage "https://github.com/stickycode/kubesec"
  url "https://github.com/stickycode/kubesec/archive/0.9.3.tar.gz"
  sha256 "d73cd0202c7563cc1dfbc2ee0804f8d77e9380646c21f9fe3f9ed9e5eb82f67a"
  head "https://github.com/stickycode/kubesec.git"
  version "0.9.3"
  depends_on "go" => :build

  option "with-short-name", "link as ksec instead"

  def install
    ENV["GOPATH"] = buildpath
    ENV["PATH"]  = "#{ENV["PATH"]}:#{ENV["GOPATH"]}/bin"
    (buildpath/"src/github.com/stickycode/kubesec").install buildpath.children
    cd "src/github.com/stickycode/kubesec" do
      system "make", "fetch"
      system "make", "build"
      bin.install "kubesec" => build.with?("short-name") ? "ksec" : "kubesec"
    end
  end

  test do
    system bin/"kubesec", "--version"
  end
end
