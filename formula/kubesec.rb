class Kubesec < Formula
  desc "A tool for encrypting and decrypting k8s secrets with AWS KMS"
  homepage "https://github.com/shyiko/kubesec"
  url "https://github.com/shyiko/kubesec/archive/0.9.0.tar.gz"
  sha256 "d36a81093322fdaaa2041f94a4efb7be978cabd691e2b88372e66f13550b4093"
  head "https://github.com/shyiko/kubesec.git"
  version "0.9.0"
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
    system bin/"kubesec"
  end
end
