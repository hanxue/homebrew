require 'formula'

class Asterisk < Formula
  homepage 'http://www.asterisk.org'
  url 'http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-11.5.1.tar.gz'
  mirror 'http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-11.5.1.tar.gz'
  sha1 'fd2d568dbb6d75be17b141466ee3e276d4910e23'

  head do
    url 'http://svn.asterisk.org/svn/asterisk/branches/11', :using => :svn

    depends_on :autoconf
    depends_on :automake
    depends_on :libtool
  end

  # option 'with-qt', 'Use QT for GUI instead of GTK+'

  depends_on 'pkg-config' => :build


  def install
	
	# use GCC instead of Clang
	# ENV['CC']= '/usr/bin/gcc'
	
    args = ["--prefix=#{prefix}"
    		
    		]

    args << "--disable-warnings-as-errors" if build.head?

    system "./configure", *args
    system "make"
    # ENV.deparallelize # parallel install fails
    system "make install"
  end

end
