# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils findlib multilib

DESCRIPTION="The Zarith library implements arithmetic and logical operations over arbitrary-precision integers"
HOMEPAGE="http://forge.ocamlcore.org/projects/zarith"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1199/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt doc mpir"

DEPEND=">=dev-lang/ocaml-3.12.1[ocamlopt?]
		!mpir? ( dev-libs/gmp )
		mpir? ( sci-libs/mpir )"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i ${S}/project.mak -e "s:(OCAMLFIND) install:(OCAMLFIND) install -ldconf \$(INSTALLDIR)/ld.conf:g"
}

src_configure(){
	MY_OPTS="-ocamllibdir /usr/$(get_libdir) -installdir ${D}/usr/$(get_libdir)/ocaml"
	use mpir && MY_OPTS="${MY_OPTS} -mpir"
	./configure ${MY_OPTS}|| die || die "configure failed"
}

src_compile(){
	emake || die "emake failed"
	use doc && emake doc || die "emake doc failed"
}

src_install(){
	findlib_src_preinst
	cp /usr/$(get_libdir)/ocaml/ld.conf ${D}/usr/$(get_libdir)/ocaml/ld.conf
	emake install || die "emake install failed"
	rm -f ${D}/usr/$(get_libdir)/ocaml/ld.conf
	dodoc Changes README
	use doc && dodoc -r html/
}
