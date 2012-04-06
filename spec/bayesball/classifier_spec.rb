require 'spec_helper'

describe Bayesball::Classifier do
  let(:subject) { Bayesball::Classifier.new }

  it 'should add category on train' do
    subject.train('basketball', 'The ball went in the hoop')
    subject.categories.include?('basketball').must_equal true
  end

  it 'should do word counts' do
    result = subject.word_counts('Hello, friend. Hello!')
    result.must_equal({'hello' => 2, 'friend' => 1})
  end

  it 'should score a payload' do
    subject.train('basketball', 'The ball went in the hoop')
    subject.train('baseball', 'He hit another grand slam!')

    result = subject.score('The ball went in the hoop')
  end

  it 'should classify' do
    #Wikipedia
    subject.train('basketball', <<-EOF)
    Basketball is a team sport, the objective being to shoot a ball through a basket horizontally positioned to score points while following a set of rules. Usually, two teams of five players play on a marked rectangular court with a basket at each width end. Basketball is one of the world's most popular and widely viewed sports.[1]
    A regulation basketball ring consists of a rim 18 inches in diameter and 10 feet high mounted to a backboard. A team can score a field goal by shooting the ball through the basket during regular play. A field goal scores two points for the shooting team if a player is touching or closer to the basket than the three-point line, and three points (known commonly as a 3 pointer or three) if the player is behind the three-point line. The team with the most points at the end of the game wins, but additional time (overtime) may be issued when the game ends with a draw. The ball can be advanced on the court by bouncing it while walking or running (dribbling) or throwing (passing) it to a teammate. It is a violation to move without dribbling the ball (traveling), to carry it, or to double dribble (to hold the ball with both hands then resume dribbling).
    Various violations are generally called "fouls". Disruptive physical contact (a personal foul) is penalized, and a free throw is usually awarded to an offensive player if he is fouled while shooting the ball. A technical foul may also be issued when certain infractions occur, most commonly for unsportsmanlike conduct on the part of a player or coach. A technical foul gives the opposing team a free throw.
    Basketball has evolved many commonly used techniques of shooting, passing, dribbling, and rebounding, as well as specialized player positions and offensive and defensive structures (player positioning) and techniques. Typically, the tallest members of a team will play "center", "power forward" or "small forward" positions, while shorter players or those who possess the best ball handling skills and speed play "point guard" or "shooting guard".
    While competitive basketball is carefully regulated, numerous variations of basketball have developed for casual play. Competitive basketball is primarily an indoor sport played on a carefully marked and maintained basketball court, but less regulated variations are often played outdoors in both inner city and remote areas.
    EOF

    subject.train('baseball', <<-EOF)
    Baseball is a bat-and-ball sport played between two teams of nine players each. The aim is to score runs by hitting a thrown ball with a bat and touching a series of four bases arranged at the corners of a ninety-foot diamond. Players on the batting team take turns hitting against the pitcher of the fielding team, which tries to stop them from scoring runs by getting hitters out in any of several ways. A player on the batting team can stop at any of the bases and later advance via a teammate's hit or other means. The teams switch between batting and fielding whenever the fielding team records three outs. One turn at bat for each team constitutes an inning and nine innings make up a professional game. The team with the most runs at the end of the game wins.
    Evolving from older bat-and-ball games, an early form of baseball was being played in England by the mid-eighteenth century. This game was brought by immigrants to North America, where the modern version developed. By the late nineteenth century, baseball was widely recognized as the national sport of the United States. Baseball is now popular in North America, parts of Central and South America and the Caribbean, and parts of East Asia.
    In North America, professional Major League Baseball (MLB) teams are divided into the National League (NL) and American League (AL), each with three divisions: East, West, and Central. The major league champion is determined by playoffs that culminate in the World Series. Five teams make the playoffs from each league: the three regular season division winners, plus two wild card teams. Baseball is the leading team sport in both Japan and Cuba, and the top level of play is similarly split between two leagues: Japan's Central League and Pacific League; Cuba's West League and East League. In the National and Central leagues, the pitcher is required to bat, per the traditional rules. In the American, Pacific, and both Cuban leagues, there is a tenth player, a designated hitter, who bats for the pitcher. Each top-level team has a farm system of one or more minor league teams.
    EOF
    result = subject.classify('the shot did not count because he was traveling')
    result.must_equal 'basketball'

    result = subject.classify('I want to play Major League Baseball some day')
    result.must_equal 'baseball'
  end
end
