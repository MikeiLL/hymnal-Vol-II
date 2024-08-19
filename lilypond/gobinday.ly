\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c' {
  \clef treble
  \key b \major
  \time 3/4 
	\new Voice = "words" {
		\voiceOne 
		\repeat volta 2 {
			fis4~ fis8. fis16~ fis8( gis) | gis2. |
			fis4. fis4( gis8) | gis2. |
			fis4~ fis8. fis16~ fis8( gis) | gis2 gis8 cis~ | 
			cis( b) b2~ | b2. |
			gis8 fis gis2~ | gis2. |
			gis8 fis gis2~ | gis2. |
			gis4~ gis8. cis16~ cis8( b) | b4. b dis8~ | dis( cis) cis2~ | cis2. |
		}
	}
}

harmony = \relative c'' {
    \voiceTwo
      ais4~ ais8. ais16~ ais8( b) | b2. |
			ais4. ais4( b8) | b2. |
			ais4~ ais8. ais16~ ais8( b) | b2 ais8 ais~ | 
			ais( gis) gis2~ | gis2. |
			e8 dis e2~ | e2. |
			dis8 e dis2~ | dis2. |
			dis4~ dis8. gis16~ gis8~ gis | gis4. gis gis8~ | gis( fisis) ais2~ | ais2. |
}

text =  \lyricmode {
	Go -- bin__ -- day
	Mu -- kan__ day
	U -- da__ -- re a -- pa__ -- re 
	Ha -- ri -- ang. Ka -- ri -- ang 
	Near -- na -- me a -- pa -- re
}

harmonies = \chordmode {
  	gis2.:min | gis:min | gis:min | gis:min |
  	gis:min | gis:min | cis:min | cis:min |
  	cis:min | cis:min | gis:min | gis:min | 
  	gis:min | gis:min | dis:7 | dis:7 |
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff  {
    <<
    	\new Voice = "upper" { \melody }
    	\new Voice = "lower" { \harmony }
    >>
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