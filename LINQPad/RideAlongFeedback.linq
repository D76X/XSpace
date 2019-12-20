<Query Kind="Expression" />

// Refs
// https://stackoverflow.com/questions/48561573/how-to-use-linqpad-with-entity-framework-core
// https://forum.linqpad.net/discussion/1107/asp-net-core-support
// http://www.linqpad.net/richclient/datacontextdrivers.aspx

//var rex = referenceContext
                //    .RideAlong
                //    .Where(r => r.SalesRepId == testSalesRepId &&
                //                r.Day.Date <= refDate &&
                //                r.Day.Date >= refDate)
                //    .Take(10);

                //----------------------------------------------------------------------

                //----------------------------------------------------------------------
                //
                // var firstDay = refDate.AddDays(-prev).Day;
                // var lastDay = refDate.AddDays(next).Day;
                // var rideDay = testRideAlong.FirstOrDefault().Day.Day;
                // var testDay = rideDay <= lastDay && rideDay >= firstDay;

                //var testx = referenceContext
                //    .RideAlong
                //    .Where(r =>
                //        r.SalesRepId == testSalesRepId &&
                //        r.Day.Day <= lastDay &&
                //        r.Day.Day >= firstDay);

                //this blows up in the debugger?
                //var testRideAlongAndDate = referenceContext
                //    .RideAlong
                //    .Where(r =>
                //        r.SalesRepId == testSalesRepId &&
                //        r.Day.Day <= refDate.AddDays(next).Day &&
                //        r.Day.Day >= refDate.AddDays(-prev).Day);

                //-------------------------------------------------------------------
                //TODO DS refactoring make this query more efficient

                // use the salesRepId to find in the Calendar
                // all the RideAlongId for that salesRepId
                // in the interval [refDate-prev,refDate+next]
                // each SalesRep is assumed to only have at most 
                // 1 RideAlong each day with his own AreaManager.

                // method 1 - to debug
                //var rideAlongs = referenceContext
                //    .RideAlong
                //    .Where(r =>
                //        r.SalesRepId == salesRepId &&
                //        r.Day.Day <= refDate.AddDays(next).Day &&
                //        r.Day.Day >= refDate.AddDays(-prev).Day)
                //    .ToDictionary(t => t.Id, t => t);

                //var raFeedbacks = rafContext
                //    .RideAlongFeedback
                //    .Where(f => rideAlongs.Keys.Contains(f.RideAlongId));

                //-------------------------------------------------------------------------
                // method 2 - should result in a more efficient query on the MSSQL server 
                // This is one of the advantages 
                //var results =
                //    (from feedback in rafContext.RideAlongFeedback
                //        join rideAlong in referenceContext.RideAlong
                //            on feedback.RideAlongId equals rideAlong.Id
                //        where
                //            rideAlong.SalesRepId == salesRepId &&
                //            rideAlong.Day.Day <= refDate.AddDays(next).Day &&
                //            rideAlong.Day.Day >= refDate.AddDays(-prev).Day
                //        select new {f = feedback, r = rideAlong})
                //    .ToList()
                //    .Select(o =>
                //    {
                //        o.f.RideAlongDate = o.r.Day;
                //        return o.f;
                //    })
                //   .ToArray();

                //return results;