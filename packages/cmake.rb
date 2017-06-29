require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.7.2'
  source_url 'https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz'
  source_sha256 'dc1246c4e6d168ea4d6e042cfba577c1acd65feea27e56f5ff37df920c30cae0'

  depends_on 'buildessential'
  depends_on 'openssl'
  depends_on 'ncurses'

  def self.build
    if Dir.exist? '/usr/local/include/ncursesw'
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH /usr/local/include/ncursesw)," Modules/FindCurses.cmake'
    end
    system "./bootstrap"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
