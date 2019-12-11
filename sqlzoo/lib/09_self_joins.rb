# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
  select count(name)
  from stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    select id
    from stops
    where name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    select distinct routes.stop_id, stops.name
    from stops
    join routes
    on stops.id = routes.stop_id
    where  company = 'LRT'
    and num = '4'
  SQL
end

def connecting_routes
  
  execute(<<-SQL)
  SELECT
     company,
     num,
     COUNT(*)
   FROM
     routes
   WHERE
     stop_id = 149 OR stop_id = 53
   GROUP BY
     company, num
    having
    count(*) = 2
  SQL
end

def cl_to_lr
  execute(<<-SQL)
  SELECT
     a.company,
     a.num,
     a.stop_id,
     b.stop_id
   FROM
     routes a
   JOIN
     routes b ON (a.company = b.company AND a.num = b.num)
   WHERE
     a.stop_id = 53
     and 
     b.stop_id = (
      select stops.id
      from stops 
      where name = 'London Road'
      )
  SQL
end

def cl_to_lr_by_name
  execute(<<-SQL)
  SELECT
     a.company,
     a.num,
     stopa.name,
     stopb.name
   FROM
     routes a
   JOIN
     routes b ON (a.company = b.company AND a.num = b.num)
   JOIN
     stops stopa ON (a.stop_id = stopa.id)
   JOIN
     stops stopb ON (b.stop_id = stopb.id)
   WHERE
     stopa.name = 'Craiglockhart' 
     and stopb.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT distinct
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Haymarket' 
      and stopb.name = 'Leith'
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT distinct
      a.company,
      a.num
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart' 
      and stopb.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT distinct
          stopa.name,
          a.company,
          a.num
        FROM
          routes a
        JOIN
          routes b ON (a.company = b.company AND a.num = b.num)
        JOIN
          stops stopa ON (a.stop_id = stopa.id)
        JOIN
          stops stopb ON (b.stop_id = stopb.id)
        WHERE a.num in (
      SELECT distinct
          a.num
        FROM
          routes a
        JOIN
          routes b ON (a.company = b.company AND a.num = b.num)
        JOIN
          stops stopa ON (a.stop_id = stopa.id)
        JOIN
          stops stopb ON (b.stop_id = stopb.id)
        WHERE
          stopa.name = 'Craiglockhart'
        ) and a.company <> 'MID'
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
  select distinct a.num, a.company, a.name, b.num, b.company
  from (
    (
      SELECT
      a.company,
      a.num,
      stopb.id,
      stopb.name
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
      where stopa.name = 'Craiglockhart'
    ) a
  join
    (
      SELECT
        a.company,
        a.num,
        stopa.name,
        stopb.id
      FROM
        routes a
      JOIN
        routes b ON (a.company = b.company AND a.num = b.num)
      JOIN
        stops stopa ON (a.stop_id = stopa.id)
      JOIN
        stops stopb ON (b.stop_id = stopb.id)
        where stopa.name = 'Sighthill'
    ) b
  
  on (a.id = b.id)
  )
  SQL
end