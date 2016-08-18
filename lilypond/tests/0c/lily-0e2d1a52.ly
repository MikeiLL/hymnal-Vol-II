%% Generated by lilypond-book
%% Options: [indent=0\mm,line-width=276\pt,noindent,quote]
\include "lilypond-book-preamble.ly"


% ****************************************************************
% Start cut-&-pastable-section
% ****************************************************************



\paper {
  indent = 0\mm
  line-width = 276\pt
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
  line-width = 276\pt - 2.0 * 0.4\in
  % offset the left padding, also add 1mm as lilypond creates cropped
  % images with a little space on the right
  line-width = #(- line-width (* mm  3.000000) (* mm 1))
}

\layout {
  
}





% ****************************************************************
% ly snippet:
% ****************************************************************
\sourcefilename "gayatri_mantra.ly"
\sourcefileline 0
\version "2.19.45"

\header {
  title = "Gayatri Mantra"
  author = "anonymous"
  composer = "Music by Rivka and Mike iLL"
  tagline = "Copyright Rivka and Mike iLL Kilmer Creative Commons Attribution-NonCommercial BMI - Engraving by Lilypond"
}

#(set! paper-alist (cons '("hymnal" . (cons (* 5.5 in) (* 8 in))) paper-alist))

\paper {
  #(set-paper-size "hymnal")
  ragged-last-bottom = ##f
  print-page-number = ##f
}

melody = \relative c'' {
  \clef treble
  \key d \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		g4( a) a2 | g8( a4) a8 a4 a | g8( a4.) a4 a | g8( a4) a4. cis4 | % Om bur ... maha
		g8( a4) a8 a4 a | g8( a4) a8 a4 a | g8( a4.) a4 r | a8( bes)~ bes2. | % Om sawaha... sat yam
		a4 a8-> r8 \times 2/3 { a4 a8 } g4 | a bes g2 | a4 \times 2/3 { a4 a8 } a4 g | a bes g2 | % Om tat savitur ... dimahi
		\times 2/3 { g4( a) a } \times 2/3 { a a a } | \times 2/3 { a a a } a4 r \bar "|." % Dhi yo yo... prachodhayat
		}
}

text =  \lyricmode {
	Om bhur | Om bhu -- ga -- ha  | Om swa -- ha | Om ma -- ha |
	Om ja -- na -- ha | Om ta -- pa -- ha | Om sat | yam |
	Om tat sa -- vi -- tur | bar -- vi -- nam | Bhar -- go  de -- va -- sya | Dhi -- ma -- hi |
	Dhi -- yo yo -- na -- ha | pra -- cho -- dha -- yat |
}


twochords = \chordmode { a1 | g:m | }

harmonies = {
	\twochords \twochords
	\twochords \twochords
	\twochords \twochords
	\twochords
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { }
}


% ****************************************************************
% end ly snippet
% ****************************************************************