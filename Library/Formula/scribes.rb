require 'formula'

class DBusPython < Formula
  url 'https://pypi.python.org/packages/source/d/dbus-python/dbus-python-0.84.0.tar.gz'
  sha1 'f3b3b9c969950ddafde75c86b55cf4694c960081'
end

class Scribes < Formula
  homepage 'http://scribes.sourceforge.net/'
  url 'http://launchpad.net/scribes/0.4/scribes-milestone1/+download/scribes-0.4-dev-build954.tar.bz2'
  sha1 '0089c967872db6c72893945ba790a489620b3fc1'
  version '0.4-dev-build954'

  depends_on 'pkg-config' => :build
  depends_on 'intltool'
  depends_on :x11 
  depends_on :python => ['dbus-python']
  depends_on "pygtk"
  depends_on "d-bus"
  depends_on "gtkspell3"
  depends_on "pygtksourceview"
  depends_on "gnome-doc-utils"
  
  # Copied from ansible.rb Formula
  def wrap bin_file, pythonpath
    bin_file = Pathname.new bin_file
    libexec_bin = Pathname.new libexec/'bin'
    libexec_bin.mkpath
    mv bin_file, libexec_bin
    bin_file.write <<-EOS.undent
      #!/bin/sh
      PYTHONPATH="#{pythonpath}:$PYTHONPATH" "#{libexec_bin}/#{bin_file.basename}" "$@"
    EOS
  end
  
  def install
    # Install Python package dependencies first
    install_args = [ "setup.py", "install", "--prefix=#{libexec}" ]

    python do
      DBusPython.new.brew { system python, *install_args }
    end

    system python, "setup.py", "install", "--prefix=#{prefix}"
      
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
