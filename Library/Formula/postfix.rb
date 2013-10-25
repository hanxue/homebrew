require 'formula'

class Postfix < Formula
  homepage 'http://gtk.org/'
  url 'http://cdn.postfix.johnriley.me/mirrors/postfix-release/official/postfix-2.10.2.tar.gz'
  sha256 'f1a735a5a9ffeac8fca59046c437c3b76e7f923fb4249db2a55b2bff0306ddd4'
  
  head 'https://github.com/vdukhovni/postfix.git'
  
  devel do
  	url 'http://cdn.postfix.johnriley.me/mirrors/postfix-release/experimental/postfix-2.11-20131001.tar.gz'
  	sha256 'c678ddd6282ab0357132626cc4f583a9c539b2281ff3c8ed6fb075ad89ae1528'
  end

  #option 'with-mysql', "Include support for MySQL database"
  #option 'with-pcre', "Include support for Perl compatible regular expressions"
  #option 'with-postgresql', "Include support for PostgreSQL database"
  #option 'with-sqlite', "Include support for SQLite database"
  
  depends_on 'pkg-config' 		=> :build
  depends_on 'berkeley-db4' 	=> :recommended
  depends_on 'mysql' 			=> :optional
  depends_on 'postgresql' 		=> :optional
  depends_on 'pcre'				=> :optional
  

  def install
  	if build.head?
  	 chdir('postfix/', :verbose => true)   # Git mirror is one level above
  	end
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make" # install"
    # Prevent a conflict between this and Gtk+2
    mv bin/'gtk-update-icon-cache', bin/'gtk3-update-icon-cache'
  end

  def test
    system "#{sbin}/postconf -d"
  end
end
