# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.16.4

EAPI="3"

DESCRIPTION="Validate, compare and draw summary statistics for GTF files"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""
SRC_URI="http://mblab.wustl.edu/software/download/"${PN}"-"${PV}".tar.gz
		http://mblab.wustl.edu/software/download/eval-documentation.pdf"

DEPEND="dev-lang/perl
	dev-lang/tk
	sci-biology/vcftools
	sci-visualization/gnuplot"

RDEPEND="${DEPEND}"

src_install(){
	dobin *.pl *.py
	dodoc "${DISTDIR}"/eval-documentation.pdf
	dodoc help/*.ps
	insinto /usr/share/eval
	doins *.gtf
	insinto /usr/share/eval/perl
	doins *.pm
	# TODO: need to add this into PERL_PATH
}