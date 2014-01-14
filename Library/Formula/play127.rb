require 'formula'

class Play127 < Formula
  homepage 'http://www.playframework.org/'
  url 'http://downloads.typesafe.com/play/1.2.7/play-1.2.7.zip'
  sha1 '436739d9f7cc00567a7e4245413c9c1ebf886797'

  conflicts_with 'sox', :because => 'both install `play` binaries'
  conflicts_with 'play', :because => 'different versions of play framework'

  def install
    system "./framework/build", "publish-local" if build.head?

    # remove Windows .bat files
    rm Dir['*.bat']
    rm Dir["#{buildpath}/**/*.bat"] if build.head?

    libexec.install Dir['*']
    bin.install_symlink libexec/'play'
  end
end
