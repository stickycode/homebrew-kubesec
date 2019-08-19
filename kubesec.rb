class Kubesec < Formula
  desc "Secure Secret management for Kubernetes (with gpg, Google Cloud KMS and AWS KMS backends)"
  homepage "https://github.com/stickycode/kubesec"
  url "https://github.com/stickycode/kubesec/archive/0.9.2.1.tar.gz"
  sha256 "c161922da361b1ad7a96274e790a2cf61dd53c3182739d69ba8d2bb5c34ea36f"
  head "https://github.com/stickycode/kubesec.git"
  version "0.9.2.1"
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
