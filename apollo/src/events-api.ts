import { RESTDataSource } from '@apollo/datasource-rest';

class EventsAPI extends RESTDataSource {
  override baseURL = 'http://localhost:4000/';

//   async getEvent(id: string): Promise<Event> {
//     return this.get<Event>(`movies/${encodeURIComponent(id)}`);
//   }

//   async getMostViewedEvents(limit = '10'): Promise<Event[]> {
//     const data = await this.get('movies', {
//       params: {
//         per_page: limit.toString(), // all params entries should be strings,
//         order_by: 'most_viewed',
//       },
//     });
//     return data.results;
//   }

// an example making an HTTP POST request
async postGame(game) {
    return this.post(
      `games`, // path
      { body: game }, // request body
    );
  }
}
export default EventsAPI;



