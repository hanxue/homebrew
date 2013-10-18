require 'formula'

class DBusPython < Formula
  url 'http://dbus.freedesktop.org/releases/dbus-python/dbus-python-1.2.0.tar.gz'
  sha1 '7a00f7861d26683ab7e3f4418860bd426deed9b5'
  
  def patches
    p = []
    p << 'https://gist.github.com/hanxue/7048247/raw/698d65b94543872a0301793aa2c02c25e732fa44/dbus-python.patch'
    # Patch to create setup.py for dbus-python
    # Based on this bug https://bugs.freedesktop.org/show_bug.cgi?id=55439
    # Original patch file at https://bugs.freedesktop.org/attachment.cgi?id=80061
    p
  end
  
  def install
  	# Install dbus-python package dependency first
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end

class Scribes < Formula
  homepage 'http://scribes.sourceforge.net/'
  url 'http://launchpad.net/scribes/0.4/scribes-milestone1/+download/scribes-0.4-dev-build954.tar.bz2'
  sha1 '0089c967872db6c72893945ba790a489620b3fc1'
  version '0.4-dev-build954'

  depends_on 'pkg-config' => :build
  depends_on 'intltool'
  depends_on :x11 
  depends_on :python
  depends_on "pygtk"
  depends_on "d-bus"
  depends_on "gtkspell3"
  depends_on "pygtksourceview"
  depends_on "gnome-doc-utils"
  
  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install" 
  end

  test do
    system "scribus"
  end
end
