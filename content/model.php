<div class="collapsible-body">
    <div class="col s12 center">
        <p>The whole model is based on 7 main sector connected to each other in order to compose the whole picture of the
            cinema company. There have been given some SELECTS in order to show the main information of every sector:</p>
    </div>
    <div class="col s12 left" style="text-align: justify">
        <ul>
            <li>
                <p>
                    <b>Location:</b>
                    Include a complete address of the cinemas and general type of contacts as Phone, Email, WhatsApp,
                    etc. It is composed by some look-up tables included to extend the location information. Our decision was to create
                    7 cinemas: 2 internal cinemas in Zaragoza, 1 internal and 1 external cinemas in Madrid, 1 internal and 1 external
                    cinemas in Chicago, and 1 internal cinema in Los Angeles. Also we added two corporative offices, 1 in Zaragoza
                    and 1 in Chicago.
                    <br>
                    <i>SELECT * FROM location a INNER JOIN address b ON (a.address_id =b.address_id);</i>
                </p>
            </li>

            <li>
                <p>
                    <b>Staff:</b>
                    Personal Information about employees and their roles. Moreover, people table will help to add rewards
                    cards in the future. The company has 52 workers still working, and 3 more that left at some point. The positions are
                    divided between the corporative ones (Managers, Assistan Managers, Accountants and Human Resources Staff), and the cinema staff ones.
                    (Supervisors, Projectionists, Cashiers, Ticket Takers, Ushers and Cleaners). Every cinema has a Supervisor, a
                    Projectionist Specialist, and at least one Cashier, one Ticket Taker, one Ushier and one Cleaner.
                    <br>
                    <i>SELECT * FROM staff as a INNER JOIN staff_status as b ON (a.staff_status_id = b.staff_status_id);</i>
                </p>
            </li>

            <li>
                <p>
                    <b>Payment:</b>
                    Standardized information about payments (card, cash, etc). As we are located in Spain and in the
                    United States, we have two currency types (USD & EUR). We accept different payment methods, by cash, by card swipping, by card dipping and contact less. Every purchase is registered in the ccpayment entity
                    <br>
                    <i>SELECT * FROM ccpayment as a INNER JOIN ccpayment_card as b ON(a.ccpayment_id = b.ccpayment_id)
                        INNER JOIN currency as c ON(a.currency_id = c.currency_id);</i>
                </p>
            </li>

            <li>
                <p>
                    <b>Product:</b>
                    Normalized product metadata as family (ticket or food), class (general type of tickets and food) and
                    category (specific type). The main entity is product, where we find the different products we are currently offering.
                    Different movie tickets are sold as different products, as it happens with different foods and beverages. Also
                    depending on the unit measure (day of the week and quality seats in movies, liters in beverages and grams or
                    package's centimeters tall in foods), there are different prices stablished.
                    <br>
                    <i>SELECT * FROM product as a INNER JOIN unit_measure as b ON(a.metric_code = b.metric_code);</i>
                </p>
            </li>

            <li>
                <p>
                    <b>Film:</b>
                    Movies will have multiple genres, cast and pictures. We have a total of 15 movies, eventhough we are only
                    offering 4 currently. It is because we have the right to show the others, but perhaps them have been shown before,
                    and them will be shown again in the future. The film table is the summarization of the others, and is planned as the
                    informational film's poster. For that reason, it shows not only the name, but also the duration, the director, the
                    release date, the language and a small synopsis.
                    <br>
                    <i>SELECT * FROM film as a INNER JOIN film_cast as b ON(a.id_film = b.id_film) INNER JOIN star as c
                        ON(b.id_star = c.id_star);</i>
                </p>
            </li>

            <li>
                <p>
                    <b>Film Session:</b>
                    Film tickets are created to access to the movie. A session belongs to a unique seat, room, cinema
                    and could be displayed in a different language rather than the original. We decided to include this entities in film
                    session sector, as a new sector, because of its particular characteristics and complex relations. Different cinemas
                    have different sessions, and different sessions have different seats and tickets.
                    <br>
                    <i>SELECT * FROM film_session as a INNER JOIN film_ticket as b ON (a.id_film = b.id_film) INNER JOIN room as c
                        ON(a.numroom = c.numroom) INNER JOIN film as d ON(a.id_film = d.id_film);</i>
                </p>
            </li>

            <li>
                <p>
                    <b>Ticket:</b>
                    It is the core of the model, and it is composed by the entities ticket and ticket item. This two tables are
                    related to every other sectors, and organize the diagram. Ticket table will contain more than one item, and follows
                    the common ticket format giving informatoin related not only with the purchase, but also about when, and where it
                    took place, and who was in charge of the sale. This help to calculate incomes. Ticket item is more related to the
                    products sold, quantities and price.
                    <br>
                    <i>SELECT * FROM ticket as a INNER JOIN ticket_item as b ON (a.ticket_id = b.ticket_id;</i>
                </p>
            </li>

        </ul>
    </div>
    <div class="col s12 center">
        <a target="_blank" href="outcome/model.pdf" class="waves-effect waves-light btn"><i class="material-icons left">file_download</i>Explanation</a>
    </div>
</div>