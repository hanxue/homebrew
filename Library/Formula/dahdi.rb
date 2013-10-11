require 'formula'

class Dahdi < Formula
  homepage 'http://www.asterisk.org/downloads/dahdi'
  url 'http://downloads.asterisk.org/pub/telephony/dahdi-linux/dahdi-linux-2.7.0.1.tar.gz'
  sha1 '6ef921c53df82bca8e21438aeb90f858a21b7194'

  head do
    url 'git://git.asterisk.org/dahdi/linux'

    depends_on :autoconf
    depends_on :automake
    depends_on :libtool
  end


  depends_on 'pkg-config' => :build


  def install
    system "./autogen.sh" if build.head?

    args = ["--disable-dependency-tracking",
            "--prefix=#{prefix}"]

    args << "--disable-warnings-as-errors" if build.head?

    system "make"
    # ENV.deparallelize # parallel install fails
    system "make install"
  end

end
