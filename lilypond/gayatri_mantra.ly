\version "2.19.45"
\paper {
	line-width = 4.6\in
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
	Om tat sa -- vi -- tur | var -- en -- yam | Bhar -- go  de -- vas -- ya | Dhi -- ma -- hi |
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
    \new Staff  {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}