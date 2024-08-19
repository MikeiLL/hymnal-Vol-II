\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\partial 4. a8 gis a |
		\repeat volta 2 {
		 b4. a8 r a gis a | b( c b) a4 a8 gis a |
		 b4. a8 r a gis a | b( c b) a4 a8 gis a |
		 b4. a8 r a gis a | b( c b) a4 a8 gis a |
		}
	}
}

text =  \lyricmode {
	I wan -- na 
	know you I wan -- na 
	know__ you I wan -- na 
	know you I wan -- na 
	know__ you I wan -- na 
	know you I wan -- na 
	know__ you I wan -- na 
}

harmonies = \chordmode {
\set noChordSymbol = "" 
	\partial 4. r4. | c1 | e | a:m | f | fis:dim | f/g |
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
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}