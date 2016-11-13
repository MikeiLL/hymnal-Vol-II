\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key c \major
  \time 9/8
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 4 c4(
		\repeat volta 2 {
			f2.) ges4 ees8 | ees2 r4 f4 ges8 | f2. r4 c8 | c2. r4 c8( |
			f2.) ges4 ees8 | ees2 r4 f4 ges8 | f2. r4 c8 | b2~ b8 c d r ees | d4.( c2) r8 c( |
			f2.) ges4 ees8 | ees2 r4 f4 ges8 | f1~ f8~ | f4. r2 c4~ |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	A~om Śrīṁ Ma -- ha La -- kṣmī -- yea Sva -- ha 
	A~om Śrīṁ Ma -- ha La -- kṣmī -- yea  Sva -- ha Sva -- ha Sva -- ha__ 
	A~om Śrīṁ Ma -- ha La -- kṣmī -- yea A~
}

harmonies = \chordmode {
\set noChordSymbol = "" 
\partial 4 r4
	f1:min
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff {
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