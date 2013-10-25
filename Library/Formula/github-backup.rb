require 'formula'

class GithubBackup < Formula
  homepage 'https://github.com/joeyh/github-backup'
  url 'https://github.com/joeyh/github-backup/archive/debian/1.20131006.tar.gz'
  sha1 'bee18dd52315d493d079d28daab2e7a2278a3f01'

  head 'https://github.com/joeyh/github-backup.git'
  
  depends_on 'cabal-install' => :build
  def install
    system "make", "install"
  end

end
